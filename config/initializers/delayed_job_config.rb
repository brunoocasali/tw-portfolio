Delayed::Worker.sleep_delay = 300
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 1.minute
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = !Rails.env.test?
