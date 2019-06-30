class Detail < ApplicationRecord
  belongs_to :plan
    
  validates :destination, presence: true, length: { maximum: 255 }
  validates :amount, :numericality => :only_integer
  validate :start_end_check
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z|^\d{0}\z/
  validates :phone, format: { with: VALID_PHONE_REGEX }
  VALID_URL_REGEX = /https:\/\/|http:\/\/|^\d{0}\z/
  validates :site_url, format: { with: VALID_URL_REGEX }

  
    
  REGISTRABLE_ATTRIBUTES = %i(
    name
    start_at(1i) start_at(2i) start_at(3i) start_at(4i) start_at(5i)
    stop_at(1i) stop_at(2i) stop_at(3i) stop_at(4i) stop_at(5i)
  )
  
  private
  def start_end_check
    return unless start_at && end_at

    if start_at >= end_at
      errors.add(:start_at, 'は終了時間よりも前に設定してください')
    end
  end

end
