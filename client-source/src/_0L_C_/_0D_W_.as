﻿// Decompiled by AS3 Sorcerer 1.99
// http://www.as3sorcerer.com/

//_0L_C_._0D_W_

package _0L_C_ {
import _sp.Signal;

import flash.display.Sprite;
import flash.events.Event;

public class _0D_W_ extends Sprite {

    private const _cR_:String = "Are you really sure you want to delete ${NAME} the ${DISPLAYID}?";
    private const _0K_r:String = TwoButtonDialog.BUTTON1_EVENT;
    private const _M_4:String = TwoButtonDialog.BUTTON2_EVENT;

    public function _0D_W_() {
        this.deleteCharacter = new Signal();
        this.cancel = new Signal();
    }
    public var deleteCharacter:Signal;
    public var cancel:Signal;

    public function _02C_(_arg1:String, _arg2:String):void {
        var _local3:String = this._cR_.replace("${NAME}", _arg1).replace("${DISPLAYID}", _arg2);
        var _local4:TwoButtonDialog = new TwoButtonDialog(_local3, "Verify Deletion", "Cancel", "Delete", "/deleteDialog");
        _local4.addEventListener(this._0K_r, this.onCancel);
        _local4.addEventListener(this._M_4, this.onDelete);
        addChild(_local4);
    }

    private function onCancel(_arg1:Event):void {
        this.cancel.dispatch();
    }

    private function onDelete(_arg1:Event):void {
        this.deleteCharacter.dispatch();
    }

}
}//package _0L_C_

