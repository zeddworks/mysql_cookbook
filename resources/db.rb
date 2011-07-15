def initialize(*args)
  super
  @action = :create
end

actions :create
actions :drop

attribute :database, :kind_of => String, :name_attribute => true
attribute :owner, :kind_of => String
attribute :host, :kind_of => String
