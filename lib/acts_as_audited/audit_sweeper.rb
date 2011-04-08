class AuditSweeper < ActionController::Caching::Sweeper #:nodoc:
  cattr_accessor :current_user_method
  self.current_user_method = :current_user

  def before_create(audit)
    audit.user ||= current_user
    (additional_audit_attributes || {}).each do |k, v|
      audit.send("#{k}=", v)
    end
  end

  def current_user
    controller.send self.class.current_user_method if controller.respond_to?(self.class.current_user_method, true)
  end

  def additional_audit_attributes
    controller.send :additional_audit_attributes if controller.respond_to?(:additional_audit_attributes, true)
  end
end

ActionController::Base.class_eval do
  cache_sweeper :audit_sweeper
end
Audit.add_observer(AuditSweeper.instance)
