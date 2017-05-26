/* Copyright (c) Royal Holloway, University of London | Contact Blake Loring (blake_l@parsed.uk), Duncan Mitchell (Duncan.Mitchell.2015@rhul.ac.uk), or Johannes Kinder (johannes.kinder@rhul.ac.uk) for details or support | LICENSE.md for license details */

"use strict";

import NodeDocument from './NodeDocument';
import Utils from '../MockerUtilities';

export default {
	setup: function() {
		global.window = GLOBAL;

		global.addEventListener = Utils.nop;
		global.attachEvent = Utils.nop;

		global.removeEventListener = Utils.nop;
		global.detachEvent = Utils.nop;

		NodeDocument.setup();
	}
};