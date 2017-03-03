class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :comments
  has_many :reviews
  has_many :assigned_users_tasks
  has_many :assigned_tasks, :through => :assigned_users_tasks, source: :task
  has_many :tasks
  has_many :task_notifications, foreign_key: :creator_id

  validates :first_name, :last_name, :tel,  presence: true
  validates :first_name, :last_name, length: { minimum: 2}
  validates :role,  presence: true

  mount_uploader :photo, PhotoUploader



  ROLES = %i[Работодатель Работник].freeze

  def assign_task(task_id)
    task = Task.find(task_id)

    assigned_users_tasks.create(task: task)
    TaskNotification.create(task: task, assigned_user_id: id, creator_id: task.user_id)
  end

end
