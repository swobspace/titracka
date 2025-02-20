##
# Query for tasks
#
class TaskQuery
  attr_reader :search_options, :query

  ##
  # possible search options:
  # * :subject - string
  # * :user_id - integer
  # * :responsible_id - integer
  # * :whoever_id - integer = user or responsible
  # * :list_id - integer
  # * :without_lists - boolean
  # * :org_unit_id - integer
  # * :subtree - boolean, only in combination with org_unit_id
  # * :state_id - integer
  # * :state_ids - Array(integer)
  # * :start - datestring (2020-02-03)
  # * :resubmission - datestring (2020-02-03)
  # * :deadline - datestring (2020-02-03)
  # * :from_(start|deadline|resubmission) - datestring
  # * :to_(start|deadline|resubmission) - datestring
  # * :user - name
  # * :responsible - name
  # * :state - string
  # * :priority - string
  # * :priority_ids - Array(string)
  # * :id - integer
  # * :cross_reference - integer: search for cross_references.identifier
  # * :limit - limit result (integer)
  #
  # please note:
  #   .joins(:state)
  # must exist in relation
  #
  def initialize(relation, search_options = {})
    @relation       = relation
    @search_options = search_options.symbolize_keys
    @limit          = 0
    @query          ||= build_query
  end

  ##
  # get all matching activities
  def all
    query
  end

  ## 
  # iterate with block 
  def find_each(&block)
    query.find_each(&block)
  end

  ##
  def include?(ta)
    query.where(id: ta.id).limit(1).any?
  end

private
  attr_accessor :relation, :limit

  def build_query
    query = relation
    search_string = [] # for global search_option :search
    visible = true
    subtree = to_boolean(search_options.fetch(:subtree, false))
    without_lists = to_boolean(search_options.fetch(:without_lists, false))
    search_value  = search_options.fetch(:search, false) # for global option :search
    search_options.each do |key,value|
      case key 
      when :subtree, :without_lists
        # ignore key here
      when *string_fields
        query = query.where("tasks.#{key} ILIKE ?", "%#{value}%")
      # 1:1 matching
      when *id_fields
       query = query.where(key.to_sym => value)
      when :whoever_id
       query = query.where("tasks.responsible_id = :uid or  tasks.user_id = :uid", 
                           uid: value.to_i)
      when :org_unit_id
        if subtree
          query = query.where(org_unit_id: subtree_ids(value))
        else
          query = query.where(org_unit_id: value)
        end
        if without_lists
          query = query.where(list_id: nil)
        end
      when *date_fields
        query = query.where("to_char(tasks.#{key}, 'YYYY-MM-DD') ILIKE ?", "%#{value}%")
      when *(date_fields("from"))
        prefix, column = key.to_s.split(/_/)
        query = query.where("tasks.#{column} > ?", value)
      when *(date_fields("to"))
        prefix, column = key.to_s.split(/_/)
        query = query.where("tasks.#{column} < ?", value)
      when :user
        query = query.where(user_id: user_ids(value)) if user_ids(value).present?
      when :responsible
        query = query.where(responsible_id: user_ids(value)) if user_ids(value).present?
      when :status
        query = query.where("states.name ILIKE ?",  "%#{value}%")
        visible = false
      when :state
        query = query.where("states.state in (?)",
                            i18n_search(value, I18n.t('titracka.state')))
        visible = false
      when :state_ids
        query = query.where("tasks.state_id IN (?)", Array(value).map(&:to_i))
        visible = false
      when :priority
        query = query.where("tasks.priority in (?)",
                            i18n_search(value, I18n.t('titracka.priority')))
      when :priority_ids
        query = query.where("tasks.priority in (?)", Array(value).map(&:to_s))
      when :private
        query = query.where(private: to_boolean(value))
      when :has_references
        if to_boolean(value) == true
          query = query.where(id: relation.joins(:cross_references).pluck(:task_id).uniq)
        end
      when :cross_reference
        query = query.where(
                  id: relation.joins(:cross_references)
                              .where("cross_references.identifier ILIKE ?", "%#{value}%")
                              .pluck(:task_id).uniq)
      when :id
        query = query.where(id: value.to_i)
      when :limit
        @limit = value.to_i
      when :search
        string_fields.each do |term|
          search_string << "tasks.#{term} LIKE :search"
        end
        search_string << "tasks.user_id IN (:uids)"  if user_ids(value)
        search_string << "tasks.responsible_id IN (:uids)"  if user_ids(value)
        search_string << "states.name LIKE :search"
        search_string << "states.state IN (:states)" if i18n_search(value, I18n.t('titracka.state'))

      else
        raise ArgumentError, "unknown search option #{key}"
      end
    end
    if search_value
      query = query.where(search_string.join(' OR '), 
                          search: "%#{search_value}%",
                          uids: user_ids(search_value),
                          states: i18n_search(search_value, I18n.t('titracka.state'))
                         )
    end
    if visible
      query = query.visible
    end
    if limit > 0
      query.limit(limit)
    else
      # Rails.logger.debug("DEBUG:: query #{query.to_sql}")
      query
    end
  end

private

  def string_fields
    [ :subject ]
  end

  def date_fields(prefix = nil)
    ary = [:start, :deadline, :resubmission]
    if prefix.nil?
      ary
    else
      ary.map{|f| "#{prefix}_#{f}".to_sym}
    end
  end

  def id_fields
    [:user_id, :responsible_id, :list_id, :state_id]
  end

  def user_ids(value)
    ids = Wobauth::User.where("sn ILIKE :val OR givenname ILIKE :val OR email ILIKE :val OR displayname ILIKE :val", val: "%#{value}%").pluck(:id)
    ids
  end

  # example: i18n_search('offen', I18n.t('titracka.state')) => 'done'
  def i18n_search(value, translation = {})
    result = []
    translation.each_pair do |k,v|
      if (v =~ /#{value}/i) || value == k.to_s
        result << ((k == :notset) ? '' : k)
      end
    end
    result
  end

  def to_boolean(value)
    return true if ['ja', 'true', '1', 'yes', 'on', 't'].include?(value.to_s.downcase)
    return false if ['nein', 'false', '0', 'no', 'off', 'f'].include?(value.to_s.downcase)
    return nil
  end

  def subtree_ids(value)
    OrgUnit.where(id: value).first.subtree_ids
  end

end
