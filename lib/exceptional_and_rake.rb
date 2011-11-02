require "exceptional_and_rake/version"

module ExceptionalAndRake
  
  # Define Rake-tasks like you usually do, but instead of:
  #
  #   task :name_of_task do
  #     ...
  #   end
  #
  # you can define tasks by calling #task_with_exceptional, like this:
  #
  #   task_with_exceptional :name_of_task do
  #     raise "argh, fail!"
  #   end
  # 
  # Any thrown errors are reported to Exceptional and re-raised.
  # Exceptional has to be configured manually, this gem doesn't do that.
  def task_with_exceptional(*args, &block)
    Rake::Task.define_task(*args) do |*block_args|
      task = block_args.first
      Exceptional.rescue_and_reraise("rake #{task.name}") do
        block.call(*block_args)
      end
    end
  end
end

include ExceptionalAndRake if defined?(Rake)