require "net/http"
require "uri"
require "json"

class WseventsController < ApplicationController
  def initialize
    @host = ENV["EVENT_MS_HOST"] || "localhost"
    @port = ENV["EVENT_MS_PORT"] || "4001"
    @pathname = "http://#{@host}:#{@port}/event"
  end

  def parse_event(event)
    {
      id: event["id"],
      subject: event["subject"],
      description: event["description"],
      date: event["date"],
      entityId: event["animal_id"],
      createdAt: event["created_at"],
      updatedAt: event["updated_at"],
    }
  end

  def get_all_events_by_entity(entity_id, events)
    events = events.map { |event| parse_event(event) }
    events.select { |event| event[:entityId].eql? entity_id }
  end

  soap_service namespace: "urn:WashOutEvent", camelize_wsdl: :lower
  soap_action "getEvent",
    args: {eventId: :string},
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
      createdAt: :string,
      updatedAt: :string,
    }
  def getEvent
    uri = URI.parse("#{@pathname}/#{params[:eventId]}")
    header = {'Content-Type': "text/json"}

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, header)
    response = http.request(request)
    event = JSON.parse(response.body)
    render soap: parse_event(event)
  end

  soap_action "getEventsByEntity",
    args: {entityId: :string},
    return: {event: [{
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
      createdAt: :string,
      updatedAt: :string,
    }]}
  def getEventsByEntity
    uri = URI.parse(@pathname.to_s)
    header = {'Content-Type': "text/json"}

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, header)
    response = http.request(request)
    body = JSON.parse(response.body)

    events = get_all_events_by_entity(params[:entityId], body["list"])
    render soap: {event: events}
  end

  soap_action "updateEvent",
    args: {
      eventId: :string,
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
    },
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
      createdAt: :string,
      updatedAt: :string,
    }
  def updateEvent
    uri = URI.parse("#{@pathname}/#{params[:eventId]}")
    header = {'Content-Type': "text/json"}
    event = {
      subject: params[:subject],
      description: params[:description],
      date: params[:date],
      animal_id: params[:entityId],
    }

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri, header)
    request.body = event.to_json
    response = http.request(request)
    updated_event = JSON.parse(response.body)
    render soap: parse_event(updated_event)
  end

  soap_action "deleteEvent",
    args: {eventId: :string},
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
      createdAt: :string,
      updatedAt: :string,
    }
  def deleteEvent
    uri = URI.parse("#{@pathname}/#{params[:eventId]}")
    header = {'Content-Type': "text/json"}

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Delete.new(uri.request_uri, header)
    response = http.request(request)
    deleted_event = JSON.parse(response.body)
    render soap: parse_event(deleted_event)
  end

  soap_action "createEvent",
    args: {
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
    },
    return: {
      id: :string,
      subject: :string,
      description: :string,
      date: :string,
      entityId: :string,
      createdAt: :string,
      updatedAt: :string,
    }
  def createEvent
    uri = URI.parse(@pathname.to_s)
    header = {'Content-Type': "text/json"}
    event = {
      subject: params[:subject],
      description: params[:description],
      date: params[:date],
      animal_id: params[:entityId],
    }

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = event.to_json
    response = http.request(request)
    created_event = JSON.parse(response.body)
    render soap: parse_event(created_event)
  end
end
