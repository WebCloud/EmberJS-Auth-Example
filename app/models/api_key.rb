class ApiKey < ActiveRecord::Base
  validates :scope, inclusion: { in: %w( session api ) }
  before_create :generate_access_token, :set_expiry_date
  belongs_to :user

  scope :session, -> { where(scope: 'session') }
  scope :api,     -> { where(scope: 'api') }
  scope :active,  -> { where("expired_at >= ?", Time.now) }

  private

  def set_expiry_date
    self.expired_at = if self.scope == 'session'
                        4.hours.from_now
                      else
                        30.days_from_now
                      end
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
