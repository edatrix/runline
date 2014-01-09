FactoryGirl.define do
  factory :run do
    name "First Run Ever"
    distance 5000
    run_time 900
    workout_datetime "2014-01-08T23:22"
    user_id 1
  end

  factory :second_run, :class => Run do
    name "Second Run Ever"
    distance 10000
    run_time 2000
    workout_datetime "2014-01-10T23:22"
    user_id 1
  end
end
