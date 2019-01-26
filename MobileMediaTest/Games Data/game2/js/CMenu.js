
INITIAL_BUDGET = 15000;

function CMenu(){
    var _pStartPosAudio;
    var _oBg;
    var _oButPlay;
    var _oAudioToggle;
    var _oFade;
    
    this._init = function(){
        _oBg = createBitmap(s_oSpriteLibrary.getSprite('bg_menu'));
        s_oStage.addChild(_oBg);
        
        var divider = 10;

        //Play button
        var oSprite = s_oSpriteLibrary.getSprite('but_bg');
        var w1 = (CANVAS_WIDTH / 2) - (CANVAS_WIDTH / divider);
        _oButPlay = new CTextButton(w1,
                                    CANVAS_HEIGHT - 184,
                                    oSprite,
                                    "🎯 PLAY",
                                    FONT_GAME,
                                    "#ffffff",
                                    40
                                    );
        _oButPlay.addEventListener(ON_MOUSE_UP, this._onButPlayRelease, this);
        
        //Leaderboard button
        var oSprite = s_oSpriteLibrary.getSprite('but_bg');
        var w2 = (CANVAS_WIDTH / 2) + (CANVAS_WIDTH / divider);
        _oButScores = new CTextButton(w2,
                                    CANVAS_HEIGHT - 184,
                                    oSprite,
                                    "🏅 SCORE",
                                    FONT_GAME,
                                    "#ffffff",
                                    40
                                    );
        _oButScores.addEventListener(ON_MOUSE_UP, this._onLeaderboardRelease, this);
      
      // Star button
      var oSprite = s_oSpriteLibrary.getSprite('but_bg');
      _oButStar = new CTextButton(w1 + 130,
                                 CANVAS_HEIGHT - 84,
                                 oSprite,
                                 "🎉 RATE",
                                 FONT_GAME,
                                 "#ffffff",
                                 40
                                 );
      _oButStar.addEventListener(ON_MOUSE_UP, this._onStarRelease, this);
      
        if(DISABLE_SOUND_MOBILE === false || s_bMobile === false){
            var oSprite = s_oSpriteLibrary.getSprite('audio_icon');
          _pStartPosAudio = {x: oSprite.width * 2.5 + 10, y: (oSprite.height/2) + 10};   
            
            _oAudioToggle = new CToggle(_pStartPosAudio.x,_pStartPosAudio.y,oSprite,s_bAudioActive);
            _oAudioToggle.addEventListener(ON_MOUSE_UP, this._onAudioToggle, this);
        }

        _oFade = new createjs.Shape();
        _oFade.graphics.beginFill("black").drawRect(0,0,CANVAS_WIDTH,CANVAS_HEIGHT);
        
        s_oStage.addChild(_oFade);
        
        createjs.Tween.get(_oFade).to({alpha:0}, 400).call(function(){_oFade.visible = false;});  
        
        this.refreshButtonPos (s_iOffsetX,s_iOffsetY);
    };
    
    this.unload = function(){
        _oButPlay.unload(); 
        _oButPlay = null;
        
        if(DISABLE_SOUND_MOBILE === false || s_bMobile === false){
            _oAudioToggle.unload();
            _oAudioToggle = null;
        }
        
        s_oStage.removeChild(_oBg);
        _oBg = null;
        
        s_oStage.removeChild(_oFade);
        _oFade = null;
        
        s_oMenu = null;
    };
    
    this.refreshButtonPos = function(iNewX,iNewY){
        if(DISABLE_SOUND_MOBILE === false || s_bMobile === false){
            _oAudioToggle.setPosition(_pStartPosAudio.x - iNewX,iNewY + _pStartPosAudio.y);
        }
    };
    
    this._onButPlayRelease = function(){
        this.unload();
        $(s_oMain).trigger("start_session");
        s_oMain.gotoGame();
    };
    
    this._onLeaderboardRelease = function(){
        window.location = 'openleaderboard://do';
    };

    this._onStarRelease = function(){
      window.location = 'star://do'
    };

    this._onAudioToggle = function(){
        
        createjs.Sound.setMute(s_bAudioActive);
        s_bAudioActive = !s_bAudioActive;
    };
    
    s_oMenu = this;
    
    this._init();
}

var s_oMenu = null;
