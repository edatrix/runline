module IntegrationSpecHelper
  def login_with_oauth(service = :mapmyfitness)
    visit "/auth/#{service}"
  end
end
