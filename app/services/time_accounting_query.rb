##
# Query for time_accountings
#
class TimeAccountingQuery
  attr_reader :search_options, :query

  ##
  # possible search options:
  # * :user_id - integer
  # * :user - name
  # * :date - datestring (2020-02-03)
  # * :id - integer
  # * :limit - limit result (integer)
  #
  def initialize(relation, search_options = {})
    @relation       = relation
    @search_options = search_options.symbolize_keys!
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
    search_value  = search_options.fetch(:search, false) # for global option :search
    search_options.each do |key,value|
      case key 
      when *string_fields
        query = query.where("time_accountings.#{key} LIKE ?", "%#{value}%")
      when :user_id
       query = query.where(user_id: value)
      when :date
       query = query.where(date: value)
      when :user
        query = query.where(user_id: user_ids(value)) if user_ids(value).present?
      when :id
        query = query.where(id: value.to_i)
      when :limit
        @limit = value.to_i
      when :search
        string_fields.each do |term|
          search_string << "time_accountings.#{term} LIKE :search"
        end
        search_string << "time_accountings.user_id IN (:uids)"  if user_ids(value)
      else
        raise ArgumentError, "unknown search option #{key}"
      end
    end
    if search_value
      query = query.where(search_string.join(' or '), 
                          search: "%#{search_value}%",
                          uids: user_ids(search_value)
                         )
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
    [ :description ]
  end

  def user_ids(value)
    ids = Wobauth::User.where("sn like :val or givenname like :val or email like :val or displayname like :val", val: "%#{value}%").pluck(:id)
    ids
  end

end
