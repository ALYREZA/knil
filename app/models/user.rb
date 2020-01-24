class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true,email: true
  validates :username, presence: true, uniqueness: true
  has_many :links

  def status_human  
    case self.status
    when 0
      I18n.t("active_account.disable")
    when 1
      I18n.t("active_account.active")
    else
      "Unknown"
    end
  end

  def time_of_expire
    nowDate = Time.zone.now
    expireDate = self.expired_at
    compareDate =  (expireDate - nowDate).ceil(0)
    message = "days ago expired"
    dateOf = compareDate / 86400 if compareDate 
    if compareDate > 0
      message = "next #{dateOf} days"
    elsif compareDate == 0
      message = "today"
    elsif compareDate < 0
      message = "#{dateOf.abs} days ago"
    end
    return message
  end
  
end
