function ssh --wraps ssh --description 'ssh with a TERM that remote hosts understand'
    TERM=xterm-256color command ssh $argv
end
