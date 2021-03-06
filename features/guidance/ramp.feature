@routing  @guidance
Feature: Ramp Guidance

    Background:
        Given the profile "car"
        Given a grid size of 10 meters

    Scenario: Ramp On Through Street Right
        Given the node map
            | a | b | c |
            |   | d |   |

        And the ways
            | nodes | highway       |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route     | turns                          |
            | a,d       | abc,bd,bd | depart,on ramp right,arrive |

    Scenario: Ramp On Through Street Left
        Given the node map
            |   | d |   |
            | a | b | c |

        And the ways
            | nodes | highway       |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route     | turns                         |
            | a,d       | abc,bd,bd | depart,on ramp left,arrive |

    Scenario: Ramp On Through Street Left and Right
        Given the node map
            |   | e |   |
            | a | b | c |
            |   | d |   |

        And the ways
            | nodes | highway       |
            | be    | motorway_link |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route     | turns                          |
            | a,d       | abc,bd,bd | depart,on ramp right,arrive |
            | a,e       | abc,be,be | depart,on ramp left,arrive  |

    Scenario: Ramp On Three Way Intersection Right
        Given the node map
            | a | b | c |
            |   | d |   |

        And the ways
            | nodes | highway       |
            | ab    | tertiary      |
            | bc    | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route    | turns                          |
            | a,d       | ab,bd,bd | depart,on ramp right,arrive |

    Scenario: Ramp On Three Way Intersection Right
        Given the node map
            |   |   | c |
            | a | b |   |
            |   | d |   |

        And the ways
            | nodes | highway       |
            | ab    | tertiary      |
            | bc    | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route    | turns                          |
            | a,d       | ab,bd,bd | depart,on ramp right,arrive |

    Scenario: Ramp Off Though Street
        Given the node map
            |   |   | c |
            | a | b |   |
            |   | d |   |

        And the ways
            | nodes | highway       |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route     | turns                          |
            | a,d       | abc,bd,bd | depart,on ramp right,arrive |
            | a,c       | abc,abc   | depart,arrive                  |

    Scenario: Straight Ramp Off Turning Though Street
        Given the node map
            |   |   | c |
            | a | b | d |

        And the ways
            | nodes | highway       |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route       | turns                             |
            | a,d       | abc,bd,bd   | depart,on ramp straight,arrive |
            | a,c       | abc,abc,abc | depart,continue left,arrive       |

    Scenario: Fork Ramp Off Turning Though Street
        Given the node map
            |   |   | c |
            | a | b |   |
            |   |   | d |

        And the ways
            | nodes | highway       |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route       | turns                             |
            | a,d       | abc,bd,bd   | depart,on ramp right,arrive    |
            | a,c       | abc,abc,abc | depart,continue left,arrive       |

    Scenario: Fork Ramp
        Given the node map
            |   |   | c |
            | a | b |   |
            |   |   | d |

        And the ways
            | nodes | highway       |
            | ab    | tertiary      |
            | bc    | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route    | turns                          |
            | a,d       | ab,bd,bd | depart,on ramp right,arrive |
            | a,c       | ab,bc,bc | depart,turn left,arrive        |

    Scenario: Fork Slight Ramp
        Given the node map
            |   |   |   | c |
            | a | b |   |   |
            |   |   |   | d |

        And the ways
            | nodes | highway       |
            | ab    | tertiary      |
            | bc    | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route    | turns                                 |
            | a,d       | ab,bd,bd | depart,on ramp slight right,arrive |
            | a,c       | ab,bc,bc | depart,turn slight left,arrive        |

    Scenario: Fork Slight Ramp on Through Street
        Given the node map
            |   |   |   | c |
            | a | b |   |   |
            |   |   |   | d |

        And the ways
            | nodes | highway       |
            | abc   | tertiary      |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route       | turns                                    |
            | a,d       | abc,bd,bd   | depart,on ramp slight right,arrive    |
            | a,c       | abc,abc,abc | depart,continue slight left,arrive       |

    Scenario: Fork Slight Ramp on Obvious Through Street
        Given the node map
            |   |   |   | c |
            | a | b |   |   |
            |   |   |   | d |

        And the ways
            | nodes | highway       |
            | abc   | primary       |
            | bd    | motorway_link |

       When I route I should get
            | waypoints | route     | turns                                 |
            | a,d       | abc,bd,bd | depart,on ramp slight right,arrive |
            | a,c       | abc,abc   | depart,arrive                         |

    Scenario: Two Ramps Joining into common Motorway
        Given the node map
            | a |   |   |   |
            |   |   | c | d |
            | b |   |   |   |

        And the ways
            | nodes | highway       |
            | ac    | motorway_link |
            | bc    | motorway_link |
            | cd    | motorway      |

        When I route I should get
            | waypoints | route    | turns                               |
            | a,d       | ac,cd,cd | depart,new name slight left,arrive  |
            | b,d       | bc,cd,cd | depart,new name slight right,arrive |

    Scenario: Two Ramps Joining into common Motorway Unnamed
        Given the node map
            | a |   |   |   |
            |   |   | c | d |
            | b |   |   |   |

        And the ways
            | nodes | highway       | name |
            | ac    | motorway_link |      |
            | bc    | motorway_link |      |
            | cd    | motorway      |      |

        When I route I should get
            | waypoints | route    | turns         |
            | a,d       | ,        | depart,arrive |
            | b,d       | ,        | depart,arrive |
