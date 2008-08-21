class Listing < ActiveRecord::Base
  
  has_many :messages
  has_many :comments
  
  serialize :language, Array
  
  #Options for status
  VALID_STATUS =  ["open", "in_progress", "closed"]
  
  #allowed language codes
  VALID_LANGUAGES = ["fi", "swe", "en-US"]
  
  VALID_CATEGORIES = ["borrow_items", "lost_property", "rides", "groups", "favors", "others", "sell", "buy", "give"]
  
  has_many :comments
  has_many :messages
  belongs_to :person
  
  #attr_accessor :language_fi, :language_en, :language_swe
  
  validates_presence_of :author_id, :category, :title, :content, :good_thru, :status, :language

  validates_inclusion_of :status, :in => VALID_STATUS
  #validates_inclusion_of :language, :in => VALID_LANGUAGES
  validates_inclusion_of :category, :in => VALID_CATEGORIES
  validates_inclusion_of :good_thru, :on => :create, :allow_nil => true, 
                         :in => DateTime.now..DateTime.now + 1.year
  
  validates_length_of :title, :within => 2..50
  validates_length_of :value_other, :allow_nil => true, :allow_blank => true, :maximum => 50
  
  validates_numericality_of :times_viewed, :value_cc, :only_integer => true, :allow_nil => true
  
  validate :given_language_is_one_of_valid_languages
  validate :language_not_empty
  
  def given_language_is_one_of_valid_languages
    language.each do |test_language|
      errors.add(:language, "should be one of the valid ones") if !VALID_LANGUAGES.include?(test_language)
    end
  end
  
  def language_not_empty
    errors.add(:language, "should not be empty") if language.empty?
  end
  
  #a method for incrementing times_viewed could be done maybe....?
  
   # def initialize(params)
   #   if params != nil
   #     languages = Array.new
   # 
   #     if params["fi"]
   #       languages << "fi"
   #     end
   # 
   #     if params["swe"]
   #       languages << "swe"
   #     end
   # 
   #     if params["en-US"]
   #       languages << "en-US"
   #     end
   #     
   #     puts languages
   #     
   #     language = languages
   #     
   #     puts language
   #     
   #     params.delete("fi")
   #     params.delete("swe")
   #     params.delete("en-US")
   # 
   #     super(params)
   #   end
   # end
    
end
