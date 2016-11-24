class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def serializable_hash(options={})
    options[:except] ||= [:created_at, :updated_at] - Array(options[:include])
    options[:include] = Array(options[:include]) - [:created_at, :updated_at]
    super(options)
  end

end
