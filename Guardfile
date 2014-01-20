guard :shell do
  watch(/^Makefile|.*\.hs$/) do |m|
    title = 'Compile'
    eager 'make'
    status = ($?.success? && :success) || :failed
    n '', title, status
    ''
  end
end
