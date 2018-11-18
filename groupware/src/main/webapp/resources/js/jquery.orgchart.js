(function($) {
    //$.fn => selector와 함께 쓰기위한 jquery 사용자 정의함수 선언
	$.fn.orgChart = function(options) {
		//$.extend  defaults와 option의 객체를 합치는데 겹치는 내용이 있다면 option의 내용을 쓴다.
        var opts = $.extend({}, $.fn.orgChart.defaults, options);
        return new OrgChart($(this), opts);        
    }
    
    // default 객체를 의미 사용자가 보낸 option 객체가 있으면 합쳐서 사용.
    $.fn.orgChart.defaults = {
        data: [{department_no:1, department_name:'Root', department_parent_no: 0}],
        showControls: false,
        allowEdit: false,
        onAddNode: null,
        onDeleteNode: null,
        onClickNode: null,
        /*newNodeText: 'Add Child'*/
    };

    //객체의 생성자 jquery변수.orgChart라는 함수를 사용하면 return new OrgChar()라는 아래의 생성자 실행
    function OrgChart($container, opts){
        var data = opts.data; // 사용자가 직접입력한 데이터
        var nodes = {};
        var rootNodes = [];
        this.opts = opts;
        this.$container = $container;
        //지금 객체를 의미
        var self = this;

        //객체의 메소드 노드를 그리는 작업 
        this.draw = function(){
        	//컨테이너를 전체 비우고  
            $container.empty().append(rootNodes[0].render(opts));
            $container.find('.node').click(function(){
                if(self.opts.onClickNode !== null){
                    self.opts.onClickNode(nodes[$(this).attr('node-department_no')]);
                }
            });

            if(opts.allowEdit){
                $container.find('.node h2').click(function(e){
                    var thisId = $(this).parent().attr('node-department_no');
                    self.startEdit(thisId);
                    e.stopPropagation();
                });
            }

            // add "add button" listener
            $container.find('.org-add-button').click(function(e){
                var thisId = $(this).parents("div.node").attr('node-department_no');
                if(self.opts.onAddNode !== null){
                    self.opts.onAddNode(nodes[thisId]);
                }
                else{
                    self.newNode(thisId);
                }
                e.stopPropagation();
            });

            $container.find('.org-del-button').click(function(e){
            	var con_val = confirm("정말 삭제하시겠어요?");
            	if(!con_val){
            		return;
            	}
                var thisId = $(this).parents("div.node").attr('node-department_no');

                if(self.opts.onDeleteNode !== null){
                	var tmpData = nodes[thisId].data;
                	self.opts.onDeleteNode(nodes[thisId]);
                	self.opts.onDeleteNodeDB(tmpData);
                }
                else{
                    self.deleteNode(thisId);
                }
                e.stopPropagation();
            });
            
            $container.find('.org-move-button').click(function(e){
            	
                var thisId = $(this).parents("div.node").attr('node-department_no');
                if(self.opts.onMoveNode !== null){
                	var tmpData = nodes[thisId].data;
                	self.opts.onMoveNode(nodes[thisId]);
                	/*self.opts.onMoveNodeDB(tmpData);*/
                }
                else{
                    self.deleteNode(thisId);
                }
                e.stopPropagation();
            });
        }
        
        this.beforeMoveCheck = function(prev,next){
        /*	console.log(prev + "/" + next);
        	console.log(nodes);*/
        	self.opts.checkNodes(prev,next);
        }
        this.moveNode = function(prev,next){
        	
        	console.log("제거전");
        	console.log(nodes);
        	console.log(nodes[prev].data.department_parent_no);
            nodes[nodes[prev].data.department_parent_no].removeChild(prev);
            nodes[prev].data.department_parent_no = next;
            nodes[nodes[prev].data.department_parent_no].addChild(nodes[prev]);
            self.draw();
            
          /*  nodes[];*/
        }

        this.startEdit = function(department_no){
            var inputElement = $('<input class="org-input" type="text" value="'+nodes[department_no].data.department_name+'"/>');
            $container.find('div[node-department_no='+department_no+'] h2').replaceWith(inputElement);
            var commitChange = function(){
                var h2Element = $('<h2>'+nodes[department_no].data.department_name+'</h2>');
                if(opts.allowEdit){
                    h2Element.click(function(){
                        self.startEdit(department_no);
                    })
                }
                inputElement.replaceWith(h2Element);
                self.opts.onChangedNodeDB(nodes[department_no].data);
            }  
            inputElement.focus();
            inputElement.keyup(function(event){
                if(event.which == 13){
                    commitChange();
                }
                else{
                    nodes[department_no].data.department_name = inputElement.val();
                }
            });
            inputElement.blur(function(event){
                commitChange();
            })
        }

        this.newNode = function(seq,parentId){
            var nextId = Object.keys(nodes).length;
            while(nextId in nodes){
                nextId++;
            }
            console.log("department_no_seq:" + department_no_seq + "/" + "department_parent_no:" + parentId);
            self.addNode({department_no: department_no_seq, department_name: '', department_parent_no: parentId});
            self.opts.onAddNodeDB({department_no: department_no_seq, department_name: '', department_parent_no: parentId})
        }

        this.addNode = function(data){
            var newNode = new Node(data);
            nodes[data.department_no] = newNode;
            nodes[data.department_parent_no].addChild(newNode);

            self.draw();
            self.startEdit(data.department_no);
        }

        this.deleteNode = function(department_no){
            for(var i=0;i<nodes[department_no].children.length;i++){
                self.deleteNode(nodes[department_no].children[i].data.department_no);
            }
            nodes[nodes[department_no].data.department_parent_no].removeChild(department_no);
            delete nodes[department_no];
            self.draw();
        }

        this.getData = function(){
            var outData = [];
            for(var i in nodes){
                outData.push(nodes[i].data);
            }
            return outData;
        }

        // constructor 실행1 노드를 생성하고 nodes라는 변수에 부서번호 index로 생성한 노드를 넣어줌.
        for(var i in data){
            var node = new Node(data[i]);
            nodes[data[i].department_no] = node;
        }

        // generate parent child tree
        for(var i in nodes){
            if(nodes[i].data.department_parent_no == 0){
                rootNodes.push(nodes[i]);
            }
            else{
                nodes[nodes[i].data.department_parent_no].addChild(nodes[i]);
            }
        }


        // draw org chart
        $container.addClass('orgChart');
        //객체를 만들면 내부의 draw()함수 호출
        self.draw();
    }

    //노드를 초기화 작업
    function Node(data){
    	
    	//사용자가 입력한 데이터를 맴버변수로 만듬 ex) {department_no : 1 , department_name :'인사' , ...}
        this.data = data;
        //자식이라는 배열, 한 단계 아래의 자식들만 저장하기 위한 변수.
        this.children = [];
        //현재객체
        var self = this;

        //자식추가 메소드 : 맴버변수 children에 넣음
        this.addChild = function(childNode){
            this.children.push(childNode);
        }

        //자식제거 메소드 : 맴버변수 
        this.removeChild = function(department_no){
        	//지금노드 객체의 자식 개수만큼 for문을 돌림.
            for(var i=0; i<self.children.length; i++){
            	//지금 객체의 자식들중에 파라미터로 받은 department_no와 같은 번호를 가지고있다면.
                if(self.children[i].data.department_no == department_no){
                	//i번째자리부터 1개만 제거 
                    self.children.splice(i,1);
                    return;
                }
            }
        }

        //테이블을 구성해주기위한 메소드
        this.render = function(opts){
        	
            var childLength = self.children.length;
            var mainTable;

            mainTable = "<table cellpadding='0' cellspacing='0' border='0'>";
            var nodeColspan = childLength>0?2*childLength:2;
            mainTable += "<tr><td colspan='"+nodeColspan+"'>"+self.formatNode(opts)+"</td></tr>";

            if(childLength > 0){
                var downLineTable = "<table cellpadding='0' cellspacing='0' border='0'><tr class='lines x'><td class='line left half'></td><td class='line right half'></td></table>";
                mainTable += "<tr class='lines'><td colspan='"+childLength*2+"'>"+downLineTable+'</td></tr>';

                var linesCols = '';
                for(var i=0;i<childLength;i++){
                    if(childLength==1){
                        linesCols += "<td class='line left half'></td>";    // keep vertical lines aligned if there's only 1 child
                    }
                    else if(i==0){
                        linesCols += "<td class='line left'></td>";     // the first cell doesn't have a line in the top
                    }
                    else{
                        linesCols += "<td class='line left top'></td>";
                    }

                    if(childLength==1){
                        linesCols += "<td class='line right half'></td>";
                    }
                    else if(i==childLength-1){
                        linesCols += "<td class='line right'></td>";
                    }
                    else{
                        linesCols += "<td class='line right top'></td>";
                    }
                }
                mainTable += "<tr class='lines v'>"+linesCols+"</tr>";

                mainTable += "<tr>";
                for(var i in self.children){
                    mainTable += "<td colspan='2'>"+self.children[i].render(opts)+"</td>";
                }
                mainTable += "</tr>";
            }
            mainTable += '</table>';
            return mainTable;
        }
        
        //노드 한개를 구성하는 메소드
        this.formatNode = function(opts){
        	var countString = '';
            var nameString = '';
            
            if(typeof data.department_name !== 'undefined'){
                nameString = '<h2>'+self.data.department_name+'</h2>';
            }
            if(typeof data.department_people_cnt !== 'undefined'){
            	countString += '<div class="people_cnt"> <i class="far fa-user"></i> ' + self.data.department_people_cnt + '</div>';
            }
            if(opts.showControls){
            	if(self.data.department_no==1){
            		var buttonsHtml = "<div><i class='fas fa-folder-plus org-add-button'></i></div>";
            	}else{
            		var buttonsHtml = "<div><i class='fas fa-folder-plus org-add-button'></i><i class='org-del-button fas fa-folder-minus'></i><i class='org-move-button fas fa-arrows-alt'></i></div>";
            	}
            }
            else{
                buttonsHtml = '';
            }
            return "<div class='node' node-department_no='"+this.data.department_no+"'>"+nameString+countString+buttonsHtml+"</div>";
        }
    }

})(jQuery);

