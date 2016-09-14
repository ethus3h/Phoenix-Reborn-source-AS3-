﻿// Decompiled by AS3 Sorcerer 1.99
// http://www.as3sorcerer.com/

//_E_7.RankToolTip

package Tooltips {
import com.company.PhoenixRealmClient.objects.ObjectLibrary;
import com.company.PhoenixRealmClient.parameters.Parameters;
import com.company.PhoenixRealmClient.ui.TooltipDivider;
import com.company.PhoenixRealmClient.util.ClassQuest;
import com.company.graphic.StarGraphic;
import com.company.ui.SimpleText;

import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

public class ClassQuestRankTooltip extends TooltipBase {

    public function ClassQuestRankTooltip(_arg1:int) {
        var _local2:LegendLine;
        super(Parameters._primaryColourDefault, 1, 0xFFFFFF, 1);
        this._2U_ = new SimpleText(13, 0xB3B3B3, false, 0, 0, "Myriad Pro");
        this._2U_.setBold(true);
        this._2U_.text = ("You have earned " + _arg1);
        this._2U_.updateMetrics();
        this._2U_.filters = [new DropShadowFilter(0, 0, 0)];
        this._2U_.x = 6;
        this._2U_.y = 2;
        addChild(this._2U_);
        this.star_ = new StarGraphic();
        this.star_.transform.colorTransform = new ColorTransform((179 / 0xFF), (179 / 0xFF), (179 / 0xFF));
        this.star_.x = (this._2U_.width + 7);
        this.star_.y = (this._2U_.y + 3);
        addChild(this.star_);
        this._I_u = new SimpleText(13, 0xB3B3B3, false, 174, 0, "Myriad Pro");
        this._I_u.wordWrap = true;
        this._I_u.multiline = true;
        this._I_u.text = "You can earn more by completing Class Quests.";
        this._I_u.updateMetrics();
        this._I_u.filters = [new DropShadowFilter(0, 0, 0)];
        this._I_u.x = 6;
        this._I_u.y = 30;
        addChild(this._I_u);
        this._qc = new TooltipDivider(100, Parameters._primaryColourDark);
        this._qc.x = 6;
        this._qc.y = (height + 10);
        addChild(this._qc);
        var _local3:int = (this._qc.y + 3);
        var _local4:int;
        while (_local4 < ClassQuest.StarColors.length) {
            _local2 = new LegendLine((_local4 * ObjectLibrary.playerClassObjects.length), (((_local4 + 1) * ObjectLibrary.playerClassObjects.length) - 1), ClassQuest.StarColors[_local4]);
            _local2.x = 6;
            _local2.y = _local3;
            addChild(_local2);
            _local3 = (_local3 + _local2.height);
            _local4++;
        }
        _local2 = new LegendLine(ClassQuest.GetMaxClassQuests(), ClassQuest.GetMaxClassQuests(), new ColorTransform((0xFF / 0xFF), (0 / 0xFF), (0xFF / 0xFF)));
        _local2.x = 6;
        _local2.y = _local3;
        addChild(_local2);
        height = (height + 6);
    }
    private var _2U_:SimpleText;
    private var star_:StarGraphic;
    private var _I_u:SimpleText;
    private var _qc:TooltipDivider;
    private var _M_J_:Vector.<LegendLine>;

    override public function draw():void {
        this._qc._rs((width - 10), Parameters._primaryColourDark);
        super.draw();
    }

}
}//package _E_7

import com.company.graphic.StarGraphic;
import com.company.ui.SimpleText;

import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

class LegendLine extends Sprite {

    /*private*/
    internal var coloredStar_:StarGraphic;
    /*private*/
    internal var rangeText_:SimpleText;
    /*private*/
    internal var star_:StarGraphic;

    public function LegendLine(_arg1:int, _arg2:int, _arg3:ColorTransform) {
        this.coloredStar_ = new StarGraphic();
        this.coloredStar_.transform.colorTransform = _arg3;
        this.coloredStar_.y = 4;
        addChild(this.coloredStar_);
        this.rangeText_ = new SimpleText(13, 0xB3B3B3, false, 0, 0, "Myriad Pro");
        this.rangeText_.setBold(true);
        this.rangeText_.text = (": " + (((_arg1 == _arg2)) ? _arg1.toString() : ((_arg1 + " - ") + _arg2)));
        this.rangeText_.updateMetrics();
        this.rangeText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.rangeText_.x = this.coloredStar_.width;
        addChild(this.rangeText_);
        this.star_ = new StarGraphic();
        this.star_.transform.colorTransform = new ColorTransform((179 / 0xFF), (179 / 0xFF), (179 / 0xFF));
        this.star_.x = ((this.rangeText_.x + this.rangeText_.width) + 2);
        this.star_.y = 4;
        addChild(this.star_);
    }
}
