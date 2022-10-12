module ApplicationHelper
  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert fade in alert-#{type} #{tag_class}"
      }.merge(options)

      close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def link_to_sign_in_or_sign_out
    unless current_user
      link_to 'Sign in', new_user_session_path
    else
      link_to 'Sign out', destroy_user_session_path, data: { method: :delete }
    end
  end

  def s3_link(account_id, artifact_key)
    link_to artifact_key, "#{artifact_key}", target: 'new'
  end

  def link_to_buy_premium_plan_payment_panel
    current_account = ActsAsTenant.current_tenant
    if current_account && current_account.plan_free?
      button_to 'BECOME PREMIUM', buy_premium_plan_path, method: :post, data: { confirm: 'You will be redirected to a payment system.' }, class: 'btn btn-success'
    elsif current_account && current_account.plan_premium?
      link_to "You're premium!", '#', class: 'btn btn-success'
    end
  end
end
