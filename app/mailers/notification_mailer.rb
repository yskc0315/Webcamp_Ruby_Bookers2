class NotificationMailer < ApplicationMailer
	def thanks_mail(user)
		@user = user
		mail(to: @user.email, subject: '会員登録が完了しました！')
	end
end
