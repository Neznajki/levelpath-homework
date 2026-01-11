if defined?(Rails::Server)
  Rails.application.config.after_initialize do
    Rails.logger.info "[WarmupService] after_initialize hook fired. PID=#{Process.pid}"

    begin
      Rails.logger.info "[WarmupService] Starting..."
      WarmupService.call
      Rails.logger.info "[WarmupService] Completed successfully"
    rescue => e
      Rails.logger.error "[WarmupService] FAILED: #{e.class}: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")

      Rails.logger.flush if Rails.logger.respond_to?(:flush)

      # Kill the server boot if warmup fails
      raise "FATAL: WarmupService failed - server cannot start. Error: #{e.message}"
    end
  end
end
