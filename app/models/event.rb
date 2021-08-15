class Event < ApplicationRecord
  belongs_to :user
  validates :name, :startTime, :endTime,  presence: true

  
  def log_params
    puts "Name: #{name}"
    puts "Start Time: #{startTime}"
    puts "End Time: #{endTime}"
    puts "Description: #{description}"
  end
  
  def get_name
    name
  end

  def get_id
    id
  end

  def get_startTime
    startTime
  end

  def get_endTime
    endTime
  end

end
