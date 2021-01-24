class Song < ApplicationRecord
  validates :title, presence: true
  validates :released, acceptance: { accept: [true, false] }
  validate :validate_release_year
  validate :unique_this_year?
  #validates :artist_name, presence: true

  def unique_this_year?
   if Song.all.find{|song| song.title == self.title && song.artist_name == self.artist_name && song.release_year == self.release_year} != nil
     errors.add(:title, "An artist cant release a song with the same name in the same year")
   end
  end

  def validate_release_year
    current_year = Time.new.year
    if self.release_year == nil
      if self.released == true
        errors.add(:release_data, "A released song needs a released data")
      end
    elsif self.release_year > current_year
      errors.add(:release_data, "Year cannot be greater than current year")
    end
  end

end
