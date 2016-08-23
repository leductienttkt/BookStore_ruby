# ClientSideValidations Initializer
#require 'client_side_validations/simple_form' if defined?(::SimpleForm)
#require 'client_side_validations/formtastic' if defined?(::Formtastic)
# Disabled validators. The uniqueness validator is disabled by default for security issues. Enable it on your own responsibility!
#ClientSideValidations::Config.disabled_validators = [:uniqueness]

# Uncomment to validate number format with current I18n locale
ClientSideValidations::Config.number_format_with_locale = true

# Uncomment the following block if you want each input field to have the validation messages attached.
#
#Note: client_side_validation requires the error to be encapsulated within
#<label for="#{instance.send(:tag_id)}" class="message"></label>

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    %{<div class="field_with_errors">#{html_tag}

    <label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label>
    <script>
      $(document).ready(function(){
        var $group = $(".field_with_errors").parent();
        var $feedback = $group.find(".form-control-feedback");

        $feedback.addClass('glyphicon-remove');
        $group.removeClass('has-success has-feedback')
        $group.addClass('has-error has-feedback')
      });
    </script>
    </div>
    }.html_safe
    else
      %{<div class="field_with_errors">#{html_tag}</div>}.html_safe
    end
  end
