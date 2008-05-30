# Defines Trapeze::Envelope.

# A collection of messages collected by a Trapeze::Courier. This class exists
# because it is necessary to distinguish an array of messages (which are
# represented as hashes) from an array of hashes.
class Trapeze::Envelope < Array; end
