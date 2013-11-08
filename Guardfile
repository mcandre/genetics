guard :shell do
  watch('Gemfile') do |m|
    title = 'Bundler output'
    msg = 'Bundler Failure'
    status = :failed

    if `bundle`
      msg = 'Bundled'
      status = :status
    end

    n msg, title, status

    "-> #{msg}"
  end

  watch(/\.hs/) do |m|
    title = 'Make output'
    msg = 'Compilation failure'
    status = :failed

    if `make`
      msg = 'Tested'
      status = :success
    end

    n msg, title, status

    "-> #{msg}"
  end
end
