object @device => :devices

attributes :id
node :links do |device|
  %w(group).map do |association|
    document = if value = device.send(association)
      { id: value.id, type: value.class.name.underscore.pluralize }
    end
    [association, document]
  end.to_h
end