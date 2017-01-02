class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Ignore created_at and updated_at by default in JSONs
  def serializable_hash(options={})

    options = Hash.new if options.nil?
    options[:include] ||= []
    options[:except] ||= []

    options[:except] << :created_at unless (((options[:include] == :created_at) || (options[:include].kind_of?(Array) && (options[:include].include? :created_at))) || ((options[:except].kind_of?(Array) && (options[:except].include? :created_at))))
    options[:except] << :updated_at unless (((options[:include] == :updated_at) || (options[:include].kind_of?(Array) && (options[:include].include? :updated_at))) || ((options[:except].kind_of?(Array) && (options[:except].include? :updated_at))))

    options.delete(:include) if options[:include] == :created_at
    options.delete(:include) if options[:include] == :updated_at
    options[:include] -= [:created_at, :updated_at] if options[:include].kind_of?(Array)

    options.delete(:include) if options[:include] == []
    options.delete(:except) if options[:except] == []

    super(options)
  end

end
