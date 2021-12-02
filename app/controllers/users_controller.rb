class UsersController < ApplicationController
  has_scope :filter_country
  has_scope :filter_username
  has_scope :filter_price, using: %i[min_price max_price], type: :hash
  has_scope :filter_game

  def index
    @users = apply_scopes(User).all
  end

  def show
    @user = User.find_by(username: params[:username])


    @coach_slots = Slot.by_user(@user)
    @available_slots = @coach_slots.available
    @available_dates = @available_slots.map { |slot| slot.date }
    @reviews = @user.reviews

    # check if user is signed in

    @booked_dates = get_booked_dates(current_user) if user_signed_in?
  end

  def get_booked_dates(user)
    # get all the coach's slots booked by the user

    slots_booked_by_current_user = current_user.booked_slots do |slot|
      slot if slot.user == @user
    end

    slots_booked_by_current_user.map { |slot| slot.date }

  end
end
