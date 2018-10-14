class ExecuteService
  include Singleton

  # Ruby Code を実行する
  def exec_ruby_code(ruby_path, opts_string = '')
    `ruby #{ruby_path} #{opts_string}`
  end
end
