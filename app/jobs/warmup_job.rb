class WarmupJob
  include Sidekiq::Job

  def perform
    WarmupService.call
  end
end
