def initialize(*args)
  super
  @action = :create
end

actions :create
actions :drop

attribute :user, :kind_of => String, :name_attribute => true
attribute :host, :kind_of => String
attribute :password, :kind_of => String
