// Generated by CoffeeScript 1.6.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['base', 'hbs!templates/player-list'], function(base, usersList) {
  var Player, PlayersCollection, PlayersCollectionView;
  Player = (function(_super) {

    __extends(Player, _super);

    function Player() {
      return Player.__super__.constructor.apply(this, arguments);
    }

    Player.prototype.urlRoot = '/players';

    return Player;

  })(base.Model);
  PlayersCollectionView = (function(_super) {

    __extends(PlayersCollectionView, _super);

    function PlayersCollectionView() {
      return PlayersCollectionView.__super__.constructor.apply(this, arguments);
    }

    PlayersCollectionView.prototype.template = playerList;

    PlayersCollectionView.prototype.collection = {
      on: function() {}
    };

    PlayersCollectionView.prototype.initialize = function(collection) {
      return this.collection.on('all', this.render);
    };

    return PlayersCollectionView;

  })(base.View);
  PlayersCollection = (function(_super) {

    __extends(PlayersCollection, _super);

    function PlayersCollection() {
      return PlayersCollection.__super__.constructor.apply(this, arguments);
    }

    PlayersCollection.prototype.model = Player;

    PlayersCollection.prototype.urlRoot = '/players';

    return PlayersCollection;

  })(base.Collection);
  return {
    Model: Player,
    Collection: PlayersCollection,
    CollectionView: PlayersCollectionView
  };
});
