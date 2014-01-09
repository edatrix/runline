FactoryGirl.define do
  factory :run do
    name "Yesterday's Run"
    distance 5000
    run_time 900
    workout_datetime  { 1.day.ago }
    user_id 1
  end

  factory :second_run, :class => Run do
    name "Run From Two Days Ago"
    distance 10000
    run_time 2000
    workout_datetime { 2.days.ago }
    user_id 1
  end

  # factory :third_run, :class => Run do 
  #   name "Run From Yesterday"
  #   distance 5000
  #   run_time 900
  #   workout_datetime  { 1.day.ago }
  #   user_id 1
  # end
end
