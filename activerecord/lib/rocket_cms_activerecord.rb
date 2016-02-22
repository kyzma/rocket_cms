require 'awesome_nested_set'
require 'paperclip'
require 'paper_trail'
require 'friendly_id'
require 'validates_lengths_from_database'

require 'glebtv-ckeditor'
require 'geocoder'

module RocketCMS
  def self.orm
    :active_record
  end
end

require 'rocket_cms'
