class Seeder

  def initialize
    destroy_users
    destroy_runs
    generate_users
  end

  def destroy_users
    User.destroy_all
  end

  def destroy_runs
    Run.destroy_all
  end

  def generate_users
    3.times { generate_user }
  end

  def generate_user
    user = User.create(
      username: Faker::Name.name,
      email: Faker::Internet.email
      )
    generate_runs(user)
  end

  def generate_runs(user)
    3.times { generate_run(user) }
  end

  def generate_run(user)
    run = Run.create(
      name: "quick jog",
      distance: rand(1000..1600),
      run_time: rand(800..1200),
      workout_datetime: "2014-01-09 10:29:09 -0700",
      user_id: user.id
      )
  end
end

Seeder.new
