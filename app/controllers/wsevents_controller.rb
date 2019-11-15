class WseventsController < ApplicationController
  soap_service namespace: "urn:WashOutEvent", camelize_wsdl: :lower
  soap_action "getEvent",
    args: {eventId: :string},
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entity_id: :string,
      created_at: :string,
      updated_at: :string,
    }
  def getEvent
    puts "ASDASDASD"
    render soap: {
      id: 0,
      subject: "Random subject",
      description: "Random description",
      date: "2019-10-15",
      entity_id: "Id of entity this event refers for",
      created_at: "2019-10-10",
      updated_at: "2019-10-10",
    }
  end

  soap_action "updateEvent",
    args: {
      eventId: :string,
      subject: :string,
      description: :string,
      date: :string,
      entity_id: :string,
    },
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entity_id: :string,
      created_at: :string,
      updated_at: :string,
    }
  def updateEvent
    puts "ASDASDASD"
    render soap: {
      id: 0,
      subject: "Random subject",
      description: "Random description",
      date: "2019-10-15",
      entity_id: "Id of entity this event refers for",
      created_at: "2019-10-10",
      updated_at: "2019-10-10",
    }
  end

  soap_action "deleteEvent",
    args: {eventId: :string},
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entity_id: :string,
      created_at: :string,
      updated_at: :string,
    }
  def deleteEvent
    puts "ASDASDASD"
    render soap: {
      id: 0,
      subject: "Deleted subject",
      description: "Deleted description",
      date: "2019-10-15",
      entity_id: "Id of entity this event refers for",
      created_at: "2019-10-10",
      updated_at: "2019-10-10",
    }
  end

  soap_action "createEvent",
    args: {
      subject: :string,
      description: :string,
      date: :string,
      entity_id: :string,
    },
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entity_id: :string,
      created_at: :string,
      updated_at: :string,
    }
  def createEvent
    puts "ASDASDASD"
    render soap: {
      id: 0,
      subject: "Created subject",
      description: "Created description",
      date: "2019-10-15",
      entity_id: "Id of entity this event refers for",
      created_at: "2019-10-10",
      updated_at: "2019-10-10",
    }
  end
end
