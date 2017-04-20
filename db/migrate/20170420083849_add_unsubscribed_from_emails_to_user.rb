class AddUnsubscribedFromEmailsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column(
      :users,
      :unsubscribed_from_emails,
      :boolean,
      null: false,
      default: false,
    )
  end
end
