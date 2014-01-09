class Seeder
  def initialize
    destroy_users
    destroy_runs
    user = generate_user
    generate_runs(user)
  end

  def destroy_users
    User.destroy_all
  end

  def destroy_runs
    Run.destroy_all
  end

  def generate_user
    user = User.new(
      username: Faker::Name.name,
      email: Faker::Internet.email
      )

    if user.save
      puts "User: #{user.username} created!"
    end

    user
  end

  def generate_runs(user)
    3.times { generate_run(user) }
  end

  def generate_run(user)
    run = Run.create(
      name: "quick jog",
      distance: 1600,
      run_time: 1200,
      workout_datetime: "2014-01-09 10:29:09 -0700",
      user_id: user.id
      )
  end
end

Seeder.new
