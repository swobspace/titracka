# frozen_string_literal: true

class Ability
  include CanCan::Ability
  attr_reader :rights, :uid

  CONFIGURATION_MODELS =
    Titracka::CONFIGURATION_CONTROLLER.map{|c| c.singularize.camelize.constantize}

  # just for development
  def initialize(user)
    alias_action :csv, :to => :read
    alias_action :copy, :to => :read
    alias_action :search, :to => :read
    alias_action :search_form, :to => :read
    alias_action :dashboard, :to => :read
    alias_action :download, :to => :read
    alias_action :calendar, :to => :read

    #
    # contains later all collected rights (org_units per role)
    #
    @rights = create_rights_struct

    @user = user
    if @user.nil?
      nobody
    else
      @uid = @user.id
      add_rights(@user.authorities.valid(Date.today))
      add_rights(@user.group_authorities.valid(Date.today))

      if any_rights?
        compile_rights
      else
        guest
      end
    end
  end


  #
  # anonymous, not logged in
  #
  def nobody
    # can [ :create, :login], UserSession
    can :read, Home
  end

  #
  # logged_in user without any authority
  #
  def guest
    # can :manage, UserSession
    can [:read, :update ], [ Wobauth::User ], :id => @user.id
    can :read, Home
  end

  #
  # logged_in user with at least 1 authority
  #
  def basic_user
    guest
    read_configuration
    # common_reports
  end

  #
  # role reader
  #
  def reader
    reader_common
    reader_ou(@rights.reader.org_units)
  end

  #
  # common reader functions
  #
  def reader_common
    can :navigate, [:org_units, :lists, :tasks, :time_accountings]
    can :read, [List, Task, TimeAccounting, Workday], user_id: @user.id
    can :read, [Task], responsible_id: @user.id
  end

  #
  # reader: org_unit specific rights
  #
  def reader_ou(ou_ids)
    can :read, [List, Task], org_unit_id: ou_ids
    can :read, OrgUnit, id: ou_ids
  end

  #
  # role member
  #
  def member
    user_common
    member_ou(@rights.member.org_units)
  end

  #
  # role manager
  #
  def manager
    user_common
    manager_ou(@rights.manager.org_units)
  end

  #
  # common member and manager functions
  #
  def user_common
    can :navigate, [:org_units, :lists, :tasks, :time_accountings]
    # can [:read], AdUser
    can :create, [List, Note, Task, TimeAccounting, Workday]
    can [:read, :update], Task, user_id: @user.id
    can [:read, :update], Task, responsible_id: @user.id
    can [:manage], Task, user_id: @user.id, private: true
    can [:manage], Task, responsible_id: @user.id, private: true
    can :manage, [List, Note, TimeAccounting, Workday], user_id: @user.id
  end

  #
  # org_unit specific rights
  #
  def member_ou(ou_ids)
    can :work_on, OrgUnit, id: ou_ids
    can :work_on, List, org_unit_id: ou_ids
  end

  def manager_ou(ou_ids)
    can :work_on, OrgUnit, id: ou_ids
    can :read, TimeAccounting, task: { org_unit_id: ou_ids }
    can :manage, [List, Task], org_unit_id: ou_ids
  end

  #
  # OrgaAdmin: can manage all configuration stuff, but access to data
  #
  def orga_admin
    # -- org stuff
    can [:manage], CONFIGURATION_MODELS
    can [:manage], OrgUnit
    can [:navigate], [:configuration, :dashboard, :org_units, Wobauth::User]
    can [:read], Wobauth::User

    # -- user stuff
    # see Wobauth::AdminAbility
  end

  #
  # UserAdmin: can manage all user and group authority stuff
  #
  def user_admin
    # -- org stuff
    can [:navigate], [:org_units, Wobauth::User]
    # can [:read], AdUser

    # -- user stuff
    # see Wobauth::AdminAbility
  end

  #
  # Full Admin
  #
  def admin
    can    :manage, :all
    cannot [:update, :destroy], Wobauth::Role, :ro => true
  end

  def read_configuration
    can :read, CONFIGURATION_MODELS
    can :navigate, :configuration
  end

private

  def create_rights_struct
    rights = OpenStruct.new
    Wobauth::Role.all.each do |r|
      rights.send("#{r.name.underscore}=", Right.new)
    end
    rights
  end

  def add_rights(authorities)
    Array(authorities).each do |authority|
      add_right(authority)
    end
  end

  def add_right(authority)
   role = authority.role.name.underscore
   if authority.authorized_for.nil?
      @rights.send(role).all = true
    elsif authority.authorized_for_type == 'OrgUnit'
      @rights.send(role).add_org_units = authority.authorized_for.subtree_ids
    else
      raise "Rights on #{authority.authorized_for_type} not yet implemented"
    end
  end

  def any_rights?
    @anyleft ||= @rights.marshal_dump.map{|role,right| right.any_rights?}.include?(true)
  end

  #
  # compile rights from collected authority datasets
  # this includes basic user rights and deploy_ou_ids
  #
  def compile_rights
    if @rights.admin.any_rights?
      admin
    else
      basic_user
      deploy_ou_ids
      @rights.marshal_dump.each do |role,right|
        next if role == :admin
        send role if right.any_rights?
      end
    end
  end

  # deploy_ou_ids
  # each primary role is orthogonal, so org_unit_ids from higher roles
  # must be deployed top->down.
  #
  def deploy_ou_ids
    # -- manager includes reader
    @rights.reader.add_org_units = @rights.manager.org_units
    @rights.reader.add_org_units = @rights.member.org_units
  end

end
