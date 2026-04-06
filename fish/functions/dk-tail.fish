function dk-tail --description 'Watch running Docker containers'
    watch -n 2 'docker ps --format "table {{.ID}}\t {{.Image}}\t {{.Status}}"'
end
