/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	config.language = 'ko';
	// config.uiColor = '#AADC6E';
	config.toolbarGroups = [
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
		'/',
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'others', groups: [ 'others' ] },
		{ name: 'about', groups: [ 'about' ] }
	];
	
	// 사용해보신분들은 아시겠지만 기본 상태에서는 대부분의 빈 태그를 자동으로 삭제합니다. 특히 폰트어썸이나 xeicon을 사용할때 i태그를 사용하는데 이를 빈 태그로 인식해서 자동 삭제하는바람에 공백을 추가하는등의 꼼수를 부려야 삭제 되지 않습니다. 많이 사용하는 i태그가 지워지는걸 방지하기 하려면 아래의 설정을 입력하면 됩니다.
	   CKEDITOR.dtd.$removeEmpty['i'] = false;
	   
	// CKEditor 기본 상태에서는 줄바꿈을 p태그로 처리 합니다. 이것을 br태그로 변경하고자 한다면 아래 설정값을 추가하세요.
	config.enterMode = CKEDITOR.ENTER_BR;
	
	config.extraPlugins = 'uploadimage';

	config.extraPlugins = 'filetools';
	config.removeButtons = 'Save,NewPage,Preview,Print,Templates,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,RemoveFormat,CopyFormatting,CreateDiv,Blockquote,Language,Link,Unlink,Anchor,About,Maximize,ShowBlocks,Iframe,Smiley,Flash';
};
