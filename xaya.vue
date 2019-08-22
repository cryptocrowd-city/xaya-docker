<!-- Tufts VUE 3.3.0 concept-map (xaya.vue) 2019-08-19 -->
<!-- Tufts VUE: http://vue.tufts.edu/ -->
<!-- Do Not Remove: VUE mapping @version(1.1) jar:file:/home/cymon/local/VUE/VUE.jar!/tufts/vue/resources/lw_mapping_1_1.xml -->
<!-- Do Not Remove: Saved date Mon Aug 19 10:43:00 CEST 2019 by cymon on platform Linux 4.15.0-51-generic in JVM 11.0.3+7-Ubuntu-1ubuntu218.04.1 -->
<!-- Do Not Remove: Saving version @(#)VUE: built October 8 2015 at 1658 by tomadm on Linux 2.6.32-504.23.4.el6.x86_64 i386 JVM 1.7.0_21-b11(bits=32) -->
<?xml version="1.0" encoding="US-ASCII"?>
<LW-MAP xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="none" ID="0" label="xaya.vue"
    created="1566203385112" x="0.0" y="0.0" width="1.4E-45"
    height="1.4E-45" strokeWidth="0.0" autoSized="false">
    <resource referenceCreated="1566204180530" size="9928"
        spec="/home/cymon/works/xaya/xaya.vue" type="1" xsi:type="URLResource">
        <title>xaya.vue</title>
        <property key="File" value="/home/cymon/works/xaya/xaya.vue"/>
    </resource>
    <fillColor>#FFFFFF</fillColor>
    <strokeColor>#404040</strokeColor>
    <textColor>#000000</textColor>
    <font>SansSerif-plain-14</font>
    <URIString>http://vue.tufts.edu/rdf/resource/a906c7c57f0001016a0d1a6854a90b33</URIString>
    <child ID="6" label="xayad" layerID="1" created="1566203410569"
        x="109.0" y="94.0" width="128.0" height="65.0" strokeWidth="1.0"
        autoSized="false" xsi:type="node">
        <fillColor>#C1F780</fillColor>
        <strokeColor>#000000</strokeColor>
        <textColor>#000000</textColor>
        <font>Arial-bold-16</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c7c97f0001016a0d1a68c16bdab4</URIString>
        <shape arcwidth="20.0" archeight="20.0" xsi:type="roundRect"/>
    </child>
    <child ID="7" label="xaya-cli" layerID="1" created="1566203441183"
        x="103.0" y="321.5" width="128.0" height="65.0"
        strokeWidth="1.0" autoSized="false" xsi:type="node">
        <fillColor>#FEFB03</fillColor>
        <strokeColor>#000000</strokeColor>
        <textColor>#000000</textColor>
        <font>Arial-bold-16</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8037f0001016a0d1a6897d6e5a9</URIString>
        <shape arcwidth="20.0" archeight="20.0" xsi:type="roundRect"/>
    </child>
    <child ID="9" label="game" layerID="1" created="1566203525408"
        x="654.0" y="214.5" width="128.0" height="65.0"
        strokeWidth="1.0" autoSized="false" xsi:type="node">
        <fillColor>#33A8F5</fillColor>
        <strokeColor>#000000</strokeColor>
        <textColor>#000000</textColor>
        <font>Arial-bold-16</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8067f0001016a0d1a68cf1a844a</URIString>
        <shape arcwidth="20.0" archeight="20.0" xsi:type="roundRect"/>
    </child>
    <child ID="10" label="1 - xaya-cli invia la mossa a xayad"
        layerID="1" created="1566203539721" x="69.5" y="158.5"
        width="201.0" height="163.5" strokeWidth="1.0" autoSized="false"
        controlCount="0" arrowState="2" xsi:type="link">
        <strokeColor>#404040</strokeColor>
        <textColor>#404040</textColor>
        <font>Arial-plain-11</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8087f0001016a0d1a68144e5c11</URIString>
        <point1 x="167.85715" y="321.5"/>
        <point2 x="172.14285" y="159.0"/>
        <ID1 xsi:type="node">7</ID1>
        <ID2 xsi:type="node">6</ID2>
    </child>
    <child ID="11" label="ZMQ" layerID="1" created="1566203619476"
        x="328.0" y="214.0" width="90.0" height="65.0" strokeWidth="1.0"
        autoSized="false" xsi:type="node">
        <fillColor>#EA2218</fillColor>
        <strokeColor>#000000</strokeColor>
        <textColor>#000000</textColor>
        <font>Arial-bold-16</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8187f0001016a0d1a68d6444105</URIString>
        <shape xsi:type="hexagon"/>
    </child>
    <child ID="12"
        label="2 - xayad pubblica la &#xa;mossa su ZMQ (mining)"
        layerID="1" created="1566203646827" x="215.69897" y="158.47482"
        width="136.0" height="68.88913" strokeWidth="1.0"
        autoSized="false" controlCount="0" arrowState="2" xsi:type="link">
        <strokeColor>#404040</strokeColor>
        <textColor>#404040</textColor>
        <font>Arial-plain-11</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c81a7f0001016a0d1a68e1898d6f</URIString>
        <point1 x="227.12471" y="158.97482"/>
        <point2 x="340.27325" y="226.86395"/>
        <ID1 xsi:type="node">6</ID1>
        <ID2 xsi:type="node">11</ID2>
    </child>
    <child ID="13"
        label="3 - Il gioco legge la coda&#xa;ed elabora la mossa"
        layerID="1" created="1566203745619" x="417.45923" y="232.7362"
        width="237.04074" height="28.0" strokeWidth="1.0"
        autoSized="false" controlCount="0" arrowState="2" xsi:type="link">
        <strokeColor>#404040</strokeColor>
        <textColor>#404040</textColor>
        <font>Arial-plain-11</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c81d7f0001016a0d1a6825ed6fa4</URIString>
        <point1 x="654.0" y="246.90726"/>
        <point2 x="417.95926" y="246.56517"/>
        <ID1 xsi:type="node">9</ID1>
        <ID2 xsi:type="node">11</ID2>
    </child>
    <child ID="14" label="game state" layerID="1"
        created="1566203781354" x="637.0" y="371.0" width="163.0"
        height="59.0" strokeWidth="1.0" autoSized="false" xsi:type="node">
        <fillColor>#76AF31</fillColor>
        <strokeColor>#000000</strokeColor>
        <textColor>#000000</textColor>
        <font>Arial-bold-16</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8247f0001016a0d1a683faa77ba</URIString>
        <shape xsi:type="ellipse"/>
    </child>
    <child ID="15" label="4 - il game state&#xa;viene aggiornato"
        layerID="1" created="1566203790451" x="669.2549" y="278.98438"
        width="98.0" height="92.515625" strokeWidth="1.0"
        autoSized="false" controlCount="0" arrowState="2" xsi:type="link">
        <strokeColor>#404040</strokeColor>
        <textColor>#404040</textColor>
        <font>Arial-plain-11</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8267f0001016a0d1a686bb70bd5</URIString>
        <point1 x="718.10583" y="279.48438"/>
        <point2 x="718.40393" y="371.0"/>
        <ID1 xsi:type="node">9</ID1>
        <ID2 xsi:type="node">14</ID2>
    </child>
    <child ID="16" label="FE" layerID="1" created="1566204144102"
        x="653.0" y="15.5" width="128.0" height="65.0" strokeWidth="1.0"
        autoSized="false" xsi:type="node">
        <fillColor>#DAA9FF</fillColor>
        <strokeColor>#000000</strokeColor>
        <textColor>#000000</textColor>
        <font>Arial-bold-16</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a90b38697f0001016a0d1a683810f913</URIString>
        <shape arcwidth="20.0" archeight="20.0" xsi:type="roundRect"/>
    </child>
    <child ID="17"
        label="5 - FE fa chiamate API&#xa;per ottenere informazioni&#xa;sul game state"
        layerID="1" created="1566204157559" x="644.0" y="80.0"
        width="147.0" height="135.0" strokeWidth="1.0" autoSized="false"
        controlCount="0" arrowState="2" xsi:type="link">
        <strokeColor>#404040</strokeColor>
        <textColor>#404040</textColor>
        <font>Arial-plain-11</font>
        <URIString>http://vue.tufts.edu/rdf/resource/a90b38707f0001016a0d1a683f62b83e</URIString>
        <point1 x="717.1633" y="80.5"/>
        <point2 x="717.8367" y="214.5"/>
        <ID1 xsi:type="node">16</ID1>
        <ID2 xsi:type="node">9</ID2>
    </child>
    <layer ID="1" label="Layer 1" created="1566203385119" x="0.0"
        y="0.0" width="1.4E-45" height="1.4E-45" strokeWidth="0.0" autoSized="false">
        <URIString>http://vue.tufts.edu/rdf/resource/a906c8307f0001016a0d1a6876174d1b</URIString>
    </layer>
    <userZoom>1.0</userZoom>
    <userOrigin x="-14.0" y="-14.0"/>
    <presentationBackground>#202020</presentationBackground>
    <PathwayList currentPathway="0" revealerIndex="-1">
        <pathway ID="0" label="Untitled Pathway" created="1566203385105"
            x="0.0" y="0.0" width="1.4E-45" height="1.4E-45"
            strokeWidth="0.0" autoSized="false" currentIndex="-1" open="true">
            <strokeColor>#B3993333</strokeColor>
            <textColor>#000000</textColor>
            <font>SansSerif-plain-14</font>
            <URIString>http://vue.tufts.edu/rdf/resource/a906c8337f0001016a0d1a684519fcff</URIString>
            <masterSlide ID="2" created="1566203385205" x="0.0" y="0.0"
                width="800.0" height="600.0" locked="true"
                strokeWidth="0.0" autoSized="false">
                <fillColor>#000000</fillColor>
                <strokeColor>#404040</strokeColor>
                <textColor>#000000</textColor>
                <font>SansSerif-plain-14</font>
                <URIString>http://vue.tufts.edu/rdf/resource/a906c8347f0001016a0d1a681d863f43</URIString>
                <titleStyle ID="3" label="Header"
                    created="1566203385456" x="328.5" y="174.5"
                    width="143.0" height="51.0" strokeWidth="0.0"
                    autoSized="true" isStyle="true" xsi:type="node">
                    <strokeColor>#404040</strokeColor>
                    <textColor>#FFFFFF</textColor>
                    <font>Gill Sans-plain-36</font>
                    <URIString>http://vue.tufts.edu/rdf/resource/a906c8367f0001016a0d1a6892545b1a</URIString>
                    <shape xsi:type="rectangle"/>
                </titleStyle>
                <textStyle ID="4" label="Slide Text"
                    created="1566203385480" x="339.0" y="282.5"
                    width="122.0" height="35.0" strokeWidth="0.0"
                    autoSized="true" isStyle="true" xsi:type="node">
                    <strokeColor>#404040</strokeColor>
                    <textColor>#FFFFFF</textColor>
                    <font>Gill Sans-plain-22</font>
                    <URIString>http://vue.tufts.edu/rdf/resource/a906c8387f0001016a0d1a68af082ba3</URIString>
                    <shape xsi:type="rectangle"/>
                </textStyle>
                <linkStyle ID="5" label="Links" created="1566203385484"
                    x="371.5" y="385.0" width="57.0" height="30.0"
                    strokeWidth="0.0" autoSized="true" isStyle="true" xsi:type="node">
                    <strokeColor>#404040</strokeColor>
                    <textColor>#B3BFE3</textColor>
                    <font>Gill Sans-plain-18</font>
                    <URIString>http://vue.tufts.edu/rdf/resource/a906c85b7f0001016a0d1a682dcf85ee</URIString>
                    <shape xsi:type="rectangle"/>
                </linkStyle>
            </masterSlide>
        </pathway>
    </PathwayList>
    <date>2019-08-19</date>
    <modelVersion>6</modelVersion>
    <saveLocation>/home/cymon/works/xaya</saveLocation>
    <saveFile>/home/cymon/works/xaya/xaya.vue</saveFile>
</LW-MAP>
