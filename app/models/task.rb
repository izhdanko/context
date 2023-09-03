class Task < ApplicationRecord

  validates :incontext, uniqueness: { scope: :user_id }, :if => Proc.new{ |task| task.incontext? }

  belongs_to :user
  # belongs_to :user
  # has_and_belongs_to_many :users
  # has_many :taskusers
  # has_many :users, through: :taskusers

  scope :recent, ->count do
    tasks = limit(count).order('created_at DESC')
    add_length = count - tasks.size
    tasks += Array.new(add_length){ Task.new }
  end
  # scope :incomplete where completed: false
  scope :incomplete, ->{ where completed: false }
  scope :context, ->{ where incontext: true }
  scope :free, ->{ where incontext: false }

  # scope :fresh, where("created_at < ?", Time.now - 5.hours)
  # scope :fresh, ->{ where("created_at < ?", Time.now - 5.hours) }
  # scope :fresh, Proc.new{ where("created_at < ?", Time.now - 5.hours) }
  # scope :fresh, lambda{ where("created_at < ?", Time.now - 5.hours) }

  def be_incontext!
    update incontext: true
  end

end
