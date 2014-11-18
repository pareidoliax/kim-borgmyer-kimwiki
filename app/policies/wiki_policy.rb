class WikiPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    update?
  end

  def index?
    true
  end

  def show?
    record.public? || user.present?
  end

  def update?
    create?
  end
end
