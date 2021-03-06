NestedAttributes = function (config) {
  var that = this,
    defaultConfig = {
      removeStyle: 'hide',
      undeleteOnChange: false,
      add: true,
      remove: true
    };
  this.config = $.extend(defaultConfig, config);

  if (this.config.undeleteOnChange) {
    $(this.config.container).find("input, select, textarea").change(function () {
      $(that.config.container).find('.delete_' + that.config.association).prev("input[type=hidden]").val("0");
    });
  }

  $(this.config.container).find("input, select, textarea").focus(function () {
    this.select();
  });

  if (this.config.remove) {
    $(this.config.container).find('.delete_' + this.config.association).die('click');
    $(this.config.container).find('.delete_' + this.config.association).live('click', function () {
      that.remove_fields(this, that.config.association,that.config.removeStyle);

      if (that.config.removeHandler) {
        that.config.removeHandler.call(that.config.caller);
      }
    });
  }

  if (this.config.add) {
    $(this.config.container).find('.add_' + this.config.association).die('click');
    $(this.config.container).find('.add_' + this.config.association).live('click', function () {

      that.add_fields(this, that.config.association, that.config.content);

      if (that.config.addHandler) {
        that.config.addHandler.call(that.config.caller);
      }
    });
  }
};

NestedAttributes.prototype = {
  remove_fields: function (link, association, removeStyle) {
    $(link).prev("input[type=hidden]").val("1");
    if (removeStyle === 'hide' ) {
      $(link).closest(".fields").hide();
      
    }
    else if (removeStyle === 'clear' ) {
      $(link).closest(".fields").find('input').clearFields();
      $(link).closest(".fields").find('select').clearFields();
      $(link).closest(".fields").find('textarea').clearFields();
    }
    var remove_selector_classname = association + "_selector"
    var remove_selector = $(link).closest(".fields").find("." + remove_selector_classname)
    remove_selector.removeClass(remove_selector_classname).addClass(remove_selector_classname +"_removed")
  },

  add_fields: function(link, association, content) {
    var new_id = new Date().getTime(),
    regexp1 = new RegExp("new_" + association, "g"),
    regexp2 = new RegExp("new_nested_record", "g");
  
    content = content.replace(regexp1, new_id);
    content = content.replace(regexp2, 'new_nested_record_' + new_id);
    $(link).closest("." + association).find('.nested_records_' + association).append(content);
    // TODO: find some place where below function can be called and be more generic 
   wire_up_select_other_class(".nested_attribute_selector", ".nested_attribute_other", ".nested_attribute_other_label");
   
   //TODO: When MDES has outreach_language other field in languages table, remove flag to enable other field. 
   var other_flag = true;
   if (association == "outreach_languages") {
     other_flag = false
   }
   disabled_selected_options("."+association+"_selector", other_flag)
  }
};
