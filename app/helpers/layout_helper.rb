module LayoutHelper
  def show_messages
    flash.map do |name, message|
      klass = flash_class(name)
      tag.div class: "alert alert-#{klass} alert-dismissable" do
        concat tag.button "x", class: "close", type: "button", data: { dismiss: "alert" }
        concat tag.ul message, class: "list-unstyled"
      end
    end.join(' ').html_safe
  end

  def flash_class(name)
    {notice: "success", success: "success", alert: "danger", error: "danger"}[name.to_sym]
  end
end
