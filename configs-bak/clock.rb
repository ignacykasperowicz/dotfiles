app_path = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(app_path) unless $LOAD_PATH.include?(app_path)

require 'clockwork'
require_relative './boot'
require_relative './environment'

module Clockwork
  every(1.minute, HealthCheckWorker.to_s) do
    Delayed::Job.enqueue(HealthCheckWorker.new)
  end

  every(10.minutes, ProcessIncomingEmailsJob.to_s) do
    ProcessIncomingEmailsJob.perform_later
  end

  every(1.week, 'sitemap:refresh') do
    SitemapJob.perform_later
  end

  every(1.day, NestioSyncJob.to_s, at: ['7:00', '17:00']) do
    NestioSyncJob.perform_later
  end
end
