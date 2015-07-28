class Message < ActiveRecord::Base
    belongs_to :User
    validates :subject, presence: {message: 'Please enter a subject.'}
    validates :subject, length: {maximum: 25, message: "Your Subject is Too Long"}
    validates :content, presence: {message: 'Please enter a message.'}
end
