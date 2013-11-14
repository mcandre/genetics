guard :shell do
  watch(/\.hs/) do |m|
    title = 'Compile'
    msg = `make`
    status = ($?.success? && :success) || :failed

    n msg, title, status
    "-> #{msg}"
  end
end
